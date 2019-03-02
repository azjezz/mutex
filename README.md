# Mutex

Hack implementation of [`reactphp-muxted`](https://github.com/WyriHaximus/reactphp-mutex) by [WyriHaximus](https://github.com/WyriHaximus).

[![Build Status](https://travis-ci.org/azjezz/mutex.svg?branch=master)](https://travis-ci.com/azjezz/mutex)
[![Latest Stable Version](https://poser.pugx.org/azjezz/mutex/v/stable.png?)](https://packagist.org/packages/azjezz/mutex)
[![Total Downloads](https://poser.pugx.org/azjezz/mutex/downloads.png?)](https://packagist.org/packages/azjezz/mutex)
[![License](https://poser.pugx.org/azjezz/mutex/license.png?)](https://packagist.org/packages/azjezz/mutex)

---

## Install

To install via Composer, use the command below :

```console
composer require azjezz/mutex
```

## About

This package provides two things:

- An interface for [`mutex` locking](https://en.wikipedia.org/wiki/Mutual_exclusion)
- A in-memory implementation of that interface

## Example

```hack
use namespace AzJezz\Mutex;
use namespace HH\Asio;

require 'vendor/autoload.hack';

<<__EntryPoint>>
async function main(): Awaitable<void> {
  Facebook\AutoloadMap\initialize();

  $mutex = new Mutex\Memory();
  
  $jobs = vec[
    foo($mutex), // first to acquire the lock
    foo($mutex), // won't be able to acquire the lock
    foo($mutex), // same
  ];

  foreach($jobs as $job) {
    await $job;
  }
}

async function foo(
  Mutex\MutexInterface $mutex
): Awaitable<void> {
  $lock = await $mutex->acquire('foo');
  if ($lock is nonnull) {
    echo "doing things \n";
    await Asio\usleep(10000000);
    echo "finished my job, releasing the lock \n";
    await $mutex->release($lock);
    return;
  }

  echo "someone else have requested the 'foo' lock\n";
}

```

## License

The Mutex Project is open-sourced software licensed under the MIT-licensed.
