module helloworld_test;

string hello(string arg = "World"){
  return "Hello, " ~ arg ~ '!';
}

unittest {
  const int allTestsEnabled = 0;
  assert(hello() == "Hello, World!");

  assert(hello("Alice") == "Hello, Alice!");
  assert(hello("Bob") == "Hello, Bob!");
  assert(hello("") == "Hello, !");
}
