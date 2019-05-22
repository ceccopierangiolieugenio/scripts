#include <iostream>
#include <iterator>
#include <regex>
#include <string>

/*
 * Trying to replicate:
 *    echo "quick brown fox" | sed 's,[^ ]* \([^ ]*\) [^ ]*,slow \1 cat,'
 */


int main()
{
   std::string text = "Quick brown fox";
   std::regex words_re("[^ ]* ([^ ]*) [^ ]*");
   std::string replace("slow \\1 cat");

   // construct a string holding the results
   std::cout << '\n' << std::regex_replace(text, words_re, replace, std::regex_constants::format_sed) << '\n';
}
