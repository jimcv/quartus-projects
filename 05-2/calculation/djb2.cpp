#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <iomanip>

using std::cout;
using std::endl;
using std::hex;
using std::dec;

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

int main()
{
  unsigned int hash1_32 = hash(2793406464, 5381);
  unsigned int hash1_10 = hash10(hash1_32);
  cout << "Hash32: " << hash1_32 << "; " << hex << hash1_32 << dec << endl;
  cout << "Hash10: " << hash1_10 << "; " << hex << hash1_10 << dec << endl;
  cout << endl;
  unsigned int mod_exp_1 = modExp(hash1_10, 13205, 33401);
  cout << "Signature: " << mod_exp_1;
  return 0;
}


