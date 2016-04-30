from matplotlib import pyplot as pp
import math
import random

eps = 0.1


class Line:
    def __init__(self, params):
        self.x = params[0]
        self.y = params[1]
        self.dx = params[2]
        self.dy = params[3]

    def dst(self, point):
        if self.dx == 0 or self.dy == 0:
            return 100000000
        return math.fabs((point[0] - self.x) / (self.dx) -
                         (point[1] - self.y) / (self.dy))

    def get_y(self, x):
        return ((x - self.x) / (self.dx)) * self.dy + self.y


class Plot:
    def __init__(self, params):
        self.x = [p[0] for p in params]
        self.y = [p[1] for p in params]

    def dst(self, point):
        pass

    def get_z(self, x, y):
        pass

# def RANSAC_plot(points, pe):



def RANSAC_line(points, pe):
    global eps
    max_pos_points = 0

    p1 = random.choice(points)
    p2 = random.choice(points)
    hypothesis = (p1[0], p1[1], p2[0] - p1[0], p2[1] - p1[1])

    god_hypothesis = hypothesis
    N = 1
    i = 0
    while i < N:
        line = Line(hypothesis)
        pos_points = 0
        for p in points:
            if line.dst(p) < eps:
                pos_points += 1
        if (max_pos_points < pos_points):
            god_hypothesis = hypothesis
            max_pos_points = pos_points

        e = 1 - float(pos_points) / len(points)
        # print math.log10(1 - pe), math.log10(1 - (1 - e)**2), pos_points
        if math.log10(1 - (1 - e)**2) == 0:
            pass
        else:
            N = (math.log10(1 - pe)/math.log10(1 - (1 - e)**2))
            # print N

        p1 = random.choice(points)
        p2 = random.choice(points)
        hypothesis = (p1[0], p1[1], p2[0] - p1[0], p2[1] - p1[1])
        i += 1

    return god_hypothesis, N

count = 0
mid_N = 0
while count < 1000:
    line = Line((10, -5, 1, 5))
    points = [(x + 10 * (random.random() - 1),
               line.get_y(x) + 10 * (random.random() - 1)) for x in range(100)]

    # line2 = Line((-1, 40, 1, 4))
    # points += [(x + 10 * (random.random() - 1),
    #              line2.get_y(x) + 10 * (random.random() - 1)) for x in range(20)]
    points += [(300*random.random(), 300*random.random()) for _ in range(100)]

    xx = [p[0] for p in points]
    yy = [p[1] for p in points]
    # pp.scatter(xx, yy)

    got_params, N = RANSAC_line(points, 0.95)
    mid_N += N
    print ('#', count)
    # got_line = Line(got_params)
    # got_points = [(x, got_line.get_y(x)) for x in range(100)]
    # got_x = [p[0] for p in got_points]
    # got_y = [p[1] for p in got_points]
    count += 1
print (mid_N / 1000)
# pp.plot(got_x, got_y)
# pp.show()


