import math
from copy import deepcopy


class Monkey:
    def __init__(self, items, operation, test, true, false):
        self.items = items
        self.operation = operation
        self.test = test
        self.true = true
        self.false = false
        self.inspect = 0

    def inspect_worry_lvl(self):
        def _compute_new(it, o, it2):
            if o == "+":
                return it + it2
            return it * it2

        op = self.operation.split()
        for j, item in enumerate(self.items):
            item2 = item if op[2] == "old" else int(op[2])
            self.items[j] = _compute_new(item, op[1], item2)
            self.inspect += 1

    def throw_items(self, monkey2, k):
        monkey2.items.append(self.items[k])

    def get_inspected_items(self):
        return self.inspect

    def __repr__(self):
        return f"Monkey has items {self.items}"


def do_round(ms):
    for m in ms:
        m.inspect_worry_lvl()
        m.items = [math.floor(it / 3) for it in m.items]
        divisible = [(it % m.test) == 0 for it in m.items]

        for j, d in enumerate(divisible):
            number = m.true if d else m.false
            m2 = ms[number]
            m.throw_items(m2, j)

        m.items = []


def do_round_pt2(ms, prod):
    for m in ms:
        m.inspect_worry_lvl()
        m.items = [it % prod for it in m.items]

        for j, it in enumerate(m.items):
            number = m.true if (it % m.test == 0) else m.false
            m2 = ms[number]
            m.throw_items(m2, j)

        m.items = []


def get_result(m):
    inspected = []
    for opice in m:
        inspected.append(opice.get_inspected_items())

    inspected.sort()
    print(inspected[-1] * inspected[-2])


if __name__ == "__main__":
    file = open("vstup11", "r").read().split(sep="\n\n")

    monkeys = []
    product = 1
    for line in file:
        array = line.split(sep="\n")
        monkeys.append(
             Monkey(
                list(map(int, array[1][18:].split(sep=","))),
                array[2][19:],
                int(array[3][21:]),
                int(array[4][29:]),
                int(array[5][29:])
             )
         )
        product = product * int(array[3][21:])

    monkeys2 = deepcopy(monkeys)

    for _ in range(20):
        do_round(monkeys)
    get_result(monkeys)

    for _ in range(10000):
        do_round_pt2(monkeys2, product)
    get_result(monkeys2)
