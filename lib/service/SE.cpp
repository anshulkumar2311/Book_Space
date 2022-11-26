#include <iostream>
#include <string>
using namespace std;

class Animal{
     int weight;
     int height;
     string color;
     int age;
     public: 
     void Eat(){
        cout<<"Animal is Eating"<<endl;
     }

     void Walk(){
        cout<<"Animal is Walking"<<endl;
     }
};

class Fish : public Animal{
    int length;
    public:
    void swim(){
        cout<<"Fish is Swimming"<<endl;
    }
};

class Duck : public Animal{
    int length;
    public:
    void swim(){
        cout<<"Duck is Swimming"<<endl;
    }
    void walk(){
        cout<<"Duck is Walking"<<endl;
    }
};

class Zebra : public Animal{
    int length;
    public:
    void walk(){
        cout<<"Zebra is Walking"<<endl;
    }
    void Run(){
        cout<<"Zebra is Running"<<endl;
    }
};

int main() {
    Animal a;
    Fish f;
    Duck d;
    Zebra z;
    z.Eat();
    z.walk();
    z.Run();
    f.swim();
    d.swim();
    return 0;
}

