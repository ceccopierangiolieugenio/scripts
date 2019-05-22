#include <iostream>
#include <iterator>
#include <regex>
#include <string>

/*
 * Trying to replicate:
 *    echo "quick brown fox" | sed     's,[^ ]* \([^ ]*\) [^ ]*,slow \1 cat,'
 * in:
 *    g++ sed.003.cpp
 *    echo "quick brown fox" | ./a.* 's,[^ ]* ([^ ]*) [^ ]*,slow \1 cat,'
 *
 */


int main(int argc, char *argv[])
{
    if (argc != 2){
       std::cout << "Use: " << argv[0] << " <SED_REGEX>" << std::endl;
       return 0; 
    }

    std::string sed_re_str(argv[1]);
    if (sed_re_str[0] != 's'){
       std::cout << "re: '" << sed_re_str << "' not recognized" << std::endl;
       return 1;
    }

    size_t a = 1;
    size_t b = sed_re_str.find_first_of(argv[1][a], a+1);
    size_t c = sed_re_str.find_first_of(argv[1][a], b+1);

    std::string re_str = sed_re_str.substr(a+1,b-a-1);
    std::string subst_str = sed_re_str.substr(b+1,c-b-1);

    std::cout << "re:    " << re_str << '\n';
    std::cout << "subst: " << subst_str << '\n';
    
    std::regex sed_re(re_str);

    // Parsing the stdin
    for (std::string line; std::getline(std::cin, line);) {
        std::cout << std::regex_replace(line, sed_re, subst_str, std::regex_constants::format_sed) << std::endl;
        //std::cout << line << std::endl;
    }
    return 0;
}
