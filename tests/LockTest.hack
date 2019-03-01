namespace AzJezz\Mutex\Test;

use namespace AzJezz\Mutex;
use type Facebook\HackTest\HackTest;
use function Facebook\FBExpect\expect;

class LockTest extends HackTest {
  public function testGetKey(): void {
    $lock = new Mutex\Lock('foo', 'bar');

    expect($lock->getKey())->toBeSame('foo');
  }

  public function testGetRng(): void {
    $lock = new Mutex\Lock('foo', 'bar');

    expect($lock->getRng())->toBeSame('bar');
  }
}
