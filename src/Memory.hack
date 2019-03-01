namespace AzJezz\Mutex;

use namespace HH\Lib\C;
use namespace HH\Lib\SecureRandom;

final class Memory implements MutexInterface {
  private dict<string, Lock> $locks = dict[];
  public async function acquire(string $key): Awaitable<?Lock> {
    if (C\contains_key($this->locks, $key)) {
      return null;
    }

    $rng = SecureRandom\string(32);
    return $this->locks[$key] = new Lock($key, $rng);
  }

  public async function release(Lock $lock): Awaitable<bool> {
    if (!C\contains_key($this->locks, $lock->getKey())) {
      return false;
    }

    unset($this->locks[$lock->getKey()]);
    return true;
  }
}