// ------------------------------------------------------------------------------------ Isogram ---
bool is_isogram(const char phrase[]) {

  if (!phrase)
    return false;

  for (const char *it = phrase; *it != '\0'; ++it) {
    if (*it != ' ' && *it != '-') {

      for (const char *it2 = it + 1; *it2 != '\0'; ++it2) {
        if (toupper(*it) == toupper(*it2))
          return false;
      }
    }
  }
  return true;
}

// ------------------------------------------------------------------------------------ Hamming ---
int compute(const char *lhs, const char *rhs) {
  if (!lhs || !rhs)
    return -1;

  int distance = 0;
  for (; *lhs && *rhs; lhs++, rhs++) {
    if (*lhs != *rhs)
      distance++;
  }
  return (*lhs || *rhs) ? -1 : distance;
}

// ------------------------------------------------------------------------------------- Grains ---
uint64_t square(uint8_t index) { return (index > 0 && index < 65) ? 1ULL << (--index) : 0; }
uint64_t total(void) { return ~(0); } // ~ inverts all bits

// ------------------------------------------------------------------------------------ Hamming ---
// ------------------------------------------------------------------------------------- Grains ---
