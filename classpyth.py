class poly:
    def __init__(self,height,width):
        self.height = height
        self.width = width

    def bounding_box_area(self):
        return self.width*self.height

class rectangle(poly):
    def __init__(self,height,width):
        poly.__init__(self,height,width)

    def area(self):
        return self.width*self.height

class triangle(poly):
    def __init__(self,height,width):
        poly.__init__(self,height,width)

    def area(self):
        return self.width*self.height/2


