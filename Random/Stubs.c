#include <stdlib.h>
#include <errno.h>
#include <zephyr/random/random.h>

void *aligned_alloc(size_t alignment, size_t size);

// Embedded Swift currently requires posix_memalign, but the C libraries in the
// Zephyr SDK do not provide it. Let's implement it and forward the calls to
// aligned_alloc(3).
int
posix_memalign(void **memptr, size_t alignment, size_t size)
{
  void *p = aligned_alloc(alignment, size);
  if (p) {
    *memptr = p;
    return 0;
  }

  return errno;
}

int getentropy(void *buffer, size_t length) {
  sys_rand_get(buffer, length);
  return 0;
}