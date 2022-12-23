import numpy as np


def is_visible(i: int, j: int, forest: np.ndarray):
    up = forest[:i, j]
    down = forest[(i + 1):, j]
    left = forest[i, :j]
    right = forest[i, (j + 1):]

    return not (
            np.any(forest[i, j] <= up) and
            np.any(forest[i, j] <= down) and
            np.any(forest[i, j] <= left) and
            np.any(forest[i, j] <= right)
    )


def get_score(tree: int, segment: np.ndarray):
    if len(segment) == 1:
        return 1

    scores = tree - segment
    idx = np.where(scores <= 0)

    if len(idx[0]) > 0:
        return idx[0][0] + 1

    return len(segment)


def get_scenic_score(i: int, j: int, forest: np.ndarray):
    up = np.flip(forest[:i, j])
    down = forest[(i + 1):, j]
    left = np.flip(forest[i, :j])
    right = forest[i, (j + 1):]

    return get_score(forest[i, j], up) * get_score(forest[i, j], down) * get_score(forest[i, j], left) * get_score(forest[i, j], right)


if __name__ == "__main__":
    file = open("vstup8", "r").read().splitlines()

    m = len(file)
    n = len(file[0])
    grid = np.array([[int(file[i][j]) for j in range(n)] for i in range(m)])

    visible_trees = n + n + m + m - 4
    scenic_score = []

    for i in range(1, m - 1):
        for j in range(1, n - 1):
            if is_visible(i, j, grid):
                visible_trees += 1

            scenic_score.append(get_scenic_score(i, j, grid))

    print(visible_trees)
    print(np.max(scenic_score))


