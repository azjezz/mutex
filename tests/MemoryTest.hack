namespace AzJezz\Mutex\Test;

use namespace AzJezz\Mutex;
use namespace HH\Lib\{C, Vec};
use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class MemoryTest extends HackTest {
  public async function testLocksHaveUniqueRng(): Awaitable<void> {
    $mutex = new Mutex\Memory();
    $rng = vec[];
    for ($i=0; $i < 1000; $i++) { 
      $lock = await $mutex->acquire('foo');
      $lock = $lock as Mutex\Lock;
      $rng[] = $lock->getRng();
      await $mutex->release($lock);
    }

    expect(C\count(Vec\unique($rng)))->toBeSame(1000);
  }

  public async function testThatYouCantRequiredTheSameLockTwice(): Awaitable<void> {
    $mutex = new Mutex\Memory();
    $lock1 = await $mutex->acquire('foo');
    $lock2 = await $mutex->acquire('foo');

    expect($lock1)->toBeInstanceOf(Mutex\Lock::class);
    expect($lock2)->toBeNull();
  }
}
