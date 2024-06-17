#include <iostream>
#include <map>
using namespace std;

// enumtype
namespace fgd {
enum Color {
    RED,
    GREEN,
    BLUE
};
}

int main() {
    // use enumtype as the key of map
    std::map<fgd::Color, std::string> colorMap;

    // insert <key, value> pair
    colorMap[fgd::RED] = "Red";
    colorMap[fgd::GREEN] = "Green";
    colorMap[fgd::BLUE] = "Blue";

    // access the output
    std::cout << "Color of RED: " << colorMap[fgd::RED] << std::endl;
    std::cout << "Color of GREEN: " << colorMap[fgd::GREEN] << std::endl;
    std::cout << "Color of BLUE: " << colorMap[fgd::BLUE] << std::endl;

    if (colorMap.find(fgd::RED) != colorMap.end())
        cout << "find color" << endl;

    return 0;
}
