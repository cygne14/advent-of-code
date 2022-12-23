import numpy as np
from enum import Enum


class Direction(Enum):
    L = [-1, 0]
    R = [1, 0]
    U = [0, 1]
    D = [0, -1]


class Snake:
    def __init__(self, knots):
        self.coord = [[[0 for _ in range(2)] for _ in range(1)] for _ in range(knots)]
        self.knots = knots

    def do_move(self, direction: str, step: int):
        def _is_close(first, second):
            return (
                    (abs(first[-1][0] - second[-1][0]) <= 1) and
                    (abs(first[-1][1] - second[-1][1]) <= 1)
            )

        for _ in range(step):
            new = np.array(self.coord[0][-1]) + Direction[direction].value
            new = new.tolist()
            self.coord[0].append(new)

            for j in range(self.knots - 1):
                if not _is_close(self.coord[j], self.coord[j + 1]):
                    direction_vector = np.sign(np.array(self.coord[j][-1]) - np.array(self.coord[j + 1][-1]))
                    to_append = (np.array(self.coord[j + 1][-1]) + direction_vector).tolist()
                    self.coord[j + 1].append(to_append)

    def get_tail_positions(self):
        return len(np.unique(self.coord[-1], axis=0))


if __name__ == "__main__":
    file = open("vstup9", "r").read().splitlines()

    snake = Snake(10)

    for i in file:
        move = i.split(" ")
        snake.do_move(move[0], int(move[1]))

    print(snake.get_tail_positions())




