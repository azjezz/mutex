namespace AzJezz\Mutex;

interface MutexInterface {
  /**
   * Acquire a mutex. Will resolve with either a Lock object or null when it can't acquire the lock 
   * because another requester already acquired it.
   */
  public function acquire(string $key): Awaitable<?Lock>;
  
  /**
   * Release a previously acquired lock.
   */
  public function release(Lock $lock): Awaitable<bool>;
}
