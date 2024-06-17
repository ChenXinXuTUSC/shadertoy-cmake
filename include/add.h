#ifndef ADD_H
#define ADD_H

class Add
{
private:
    int a;
    int b;

public:
    Add(int _a, int _b) : a(_a), b(_b) {}

    int Calc() const;
};

#endif
