namespace AzJezz\Mutex;

final class Lock {
  public function __construct(
    private string $key,
    private string $rng
  ) {}

  public function getKey(): string {
    return $this->key;
  }

  public function getRng(): string {
    return $this->rng;
  }
}
