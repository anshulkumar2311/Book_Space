#include <iostream>
#include <string>
using namespace std;

class Geometry{
      int height;
      int width;
      int radius;
      int length;
      int breadth;
      public : 
      void area(){
      cout<<"Area :"<<endl;
      }
      void perimeter(){
        cout<<"Perimeter :"<<endl;
      }
};

class Circle : public Geometry{
     public:
     double area(int r){
        cout<<"Area of Circle :"<<3.14*r*r<<endl;
     } 
     double perimeter(int r){
        cout<<"Perimet of Circle :"<<2*3.14*r<<endl;
     }
};

class Square : public Geometry{
    public:
    double area(int side){
        cout<<"Area of Square :"<<side*side<<endl;
    }
};

class Rectangle : public Geometry{
    int l,b;
    public:
    double area(int l,int b){
        cout<<"Area of Rectangle :"<<l*b<<endl;
    }
};

int main(){
    Geometry g;
    Circle c;
    Square s;
    Rectangle r;
    s.area(7);
    r.area(7,10);
    c.area(8);
    c.perimeter(5);
}