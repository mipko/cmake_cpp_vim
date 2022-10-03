#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <new>
#include <stdio.h>
#include <string>
#include <utility>

#include <vector>

#include "Config.h"

#include "disco.h"

//izbildao sam projekat u Debug verziji, kombinacijom CTRL-M bd
//zatim sam reloadovao fajl pomocu :e
//primetitili ste da su nestale greske
//razlog je sto je cmake napravio compile DB i onda YCM plugin ume to da ucita kada se reloaduje fajl i sve radi 
//release ce se izbildati na slican nacin CTRL-m br
//ovo su moji custom key bindingsi 
//pokazacemo na kraju .vimrc


class movable{
  public:
 
    movable(){
      n = "42";
      std::cout << "pravim se\n";
    };

    movable(movable&& v):n{std::move(v.n)}{
      v.n.clear();

      std::cout << "muvam se\n";
    }

    void prd(){
      std::cout << n << std::endl;
    };
    std::string n;
};

void fg(movable&& rv){
  rv.n = "84";
  rv.prd();
  
//  std::cout <<rv << std::endl;
}


void g(std::string&& ss){

 //std::string x = std::move(ss);
}

void l(const std::string &s){
 std::string x = std::move(s);
}

int main(int argc, char** argv){
  int x = 0;
  x++;
  std::cout << "Version: " << MAJOR_VERSION << "." << MINOR_VERSION << "." << PATCH_VERSION << "\n" << f() << "\n";

  std::vector<std::string> v;

  std::string s = "mirko";

  g(std::move(s));
  //v.push_back(std::move(s));

  std::cout << s << std::endl;
  std::cout << s.size() << std::endl;




  //takojde ne moze da nadje ni ove promenljive Major, minor i patch version ?!
  std::cout << x << "\n";
  return 0;
}
