#include <iostream>
#include <iomanip>
#include <string>

using std::cout;
using std::dec;
using std::endl;
using std::hex;
using std::stoul;

unsigned int hash(unsigned int input, unsigned int oldHash)
{
  unsigned int hash = oldHash;
  hash = input + hash * 33;
  return hash;
}

unsigned int hash10(unsigned int hash32)
{
  unsigned int upperBits = hash32 >> 22;
  unsigned int lowerBits = hash32 & 1023;
  unsigned int xored = upperBits ^ lowerBits;
  unsigned int hash10 = xored & 1023;
  return hash10;
}

unsigned int modExp(unsigned int c, unsigned int d, unsigned int n)
{
  unsigned int s = 1;
  for (unsigned int k = 0; k < d; k++)
  {
    s = (c * s) % n;
  }
  return s;
}

int main(int argc, char *argv[])
{
  if (argc > 1)
  {
    // 1st hash function, takes in message source in chunks
    unsigned int oldHash_1 = 5381;
    for (int i = 1; i < argc; i++)
    {
      unsigned int chunk = stoul(argv[i], nullptr, 10);
      unsigned int hash32_1 = hash(chunk, oldHash_1);
      oldHash_1 = hash32_1;
    }
    unsigned int hash10_1 = hash10(oldHash_1);
    // concatenate timestamp, use 2022/04/08 5:00PM, which is 195209 hours after 2000
    unsigned int hash_input_2 = (hash10_1 << 22) + 195209;
    // 2nd hash function
    unsigned int hash32_2 = hash(hash_input_2, 5381);
    unsigned int hash10_2 = hash10(hash32_2);
    // exp circuit
    unsigned int mod_exp = modExp(hash10_2, 13205, 33401);
    cout << "Signature: " << mod_exp;
  }
  else
  {
    cout << "Please enter a message (as blocks of 32-bits base-10 unsigned integer, separated by space)" << endl;
  }
  return 0;
}
