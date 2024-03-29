import time
from functools import wraps

x1, x2, y1, y2 = -1.8, 1.8, -1.8, 1.8
c_real, c_imag = -0.62772, -0.42193

def timefn(fn):
    @wraps(fn)
    def measure_time(*args, **kwargs):
        t1 = time.time()
        result = fn(*args, **kwargs)
        t2 = time.time()
        print("@timefn:" + fn.__name__ + " took " + str(t2 - t1) + " seconds")
        return result
    return measure_time

@profile
def calculate_z_serial_purepython(maxiter, zs, cs):
    """Calculate output list using Julia update rule"""
    output = [0] * len(zs)
    for i in range(len(zs)):
        n = 0
        z = zs[i]
        c = cs[i]
        while abs(z) < 2 and n < maxiter:
            z = z * z + c
            n += 1
        output[i] = n
    return output

@profile
def calc_pure_python(desired_width, max_iterations):
    """Create a list of complex coordinates(zs) and complex parameters(cs), build julia set, and display"""
    x_step = (float(x2 - x1) / float(desired_width))
    y_step = (float(y2 - y1) / float(desired_width))
    x = []
    y = []
    
    ycoord = y1
    while ycoord < y2:
        y.append(ycoord)
        ycoord += y_step
        
    xcoord = x1
    while xcoord < x2:
        x.append(xcoord)
        xcoord += x_step

    zs = []
    cs = []
    for ycoord in y:
        for xcoord in x:
            zs.append(complex(xcoord, ycoord))
            cs.append(complex(c_real, c_imag))

    print("length of x: ", len(x))
    print("total elements: ", len(zs))
    start_time = time.time()
    output = calculate_z_serial_purepython(max_iterations, zs, cs)
    end_time = time.time()
    secs = end_time - start_time
    print("calculate_z_serial_purepython" + " took", secs, " secs")

if __name__ == "__main__":
    calc_pure_python(desired_width=1000, max_iterations=300)
