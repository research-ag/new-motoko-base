import Array "../src/Array";
import Int "../src/Int";
import Char "../src/Char";
import Nat "../src/Nat";
import Text "../src/Text";
import Suite "mo:matchers/Suite";
import T "mo:matchers/Testable";
import M "mo:matchers/Matchers";

let suite = Suite.suite(
  "Array",
  [
    Suite.test(
      "repeat",
      Array.repeat<Int>(4, 3),
      M.equals(T.array<Int>(T.intTestable, [4, 4, 4]))
    ),
    Suite.test(
      "repeat empty",
      Array.repeat<Int>(4, 0),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "tabulate",
      Array.tabulate<Int>(3, func(i : Nat) = i * 2),
      M.equals(T.array<Int>(T.intTestable, [0, 2, 4]))
    ),
    Suite.test(
      "tabulate empty",
      Array.tabulate<Int>(0, func(i : Nat) = i),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "fromVarArray",
      Array.fromVarArray<Int>([var 1, 2, 3]),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3]))
    ),
    Suite.test(
      "fromVarArray empty",
      Array.fromVarArray<Int>([var]),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "toVarArray round trip",
      Array.fromVarArray(Array.toVarArray<Int>([1, 2, 3])),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3]))
    ),
    Suite.test(
      "toVarArray round trip empty",
      Array.fromVarArray(Array.toVarArray<Int>([])),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "equal",
      Array.equal<Int>([1, 2, 3], [1, 2, 3], Int.equal),
      M.equals(T.bool(true))
    ),
    Suite.test(
      "equal empty",
      Array.equal<Int>([], [], Int.equal),
      M.equals(T.bool(true))
    ),
    Suite.test(
      "not equal one empty",
      Array.equal<Int>([], [2, 3], Int.equal),
      M.equals(T.bool(false))
    ),
    Suite.test(
      "not equal different lengths",
      Array.equal<Int>([1, 2, 3], [2, 4], Int.equal),
      M.equals(T.bool(false))
    ),
    Suite.test(
      "not equal same lengths",
      Array.equal<Int>([1, 2, 3], [1, 2, 4], Int.equal),
      M.equals(T.bool(false))
    ),
    Suite.test(
      "find",
      Array.find<Nat>([1, 9, 4, 8], func x = x == 9),
      M.equals(T.optional(T.natTestable, ?9))
    ),
    Suite.test(
      "find fail",
      Array.find<Nat>([1, 9, 4, 8], func _ = false),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "find empty",
      Array.find<Nat>([], func _ = true),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "findIndex",
      Array.findIndex<Nat>([1, 9, 4, 8], func x = x == 9),
      M.equals(T.optional(T.natTestable, ?1))
    ),
    Suite.test(
      "findIndex fail",
      Array.findIndex<Nat>([1, 9, 4, 8], func _ = false),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "findIndex empty",
      Array.findIndex<Nat>([], func _ = true),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "concat",
      Array.concat<Int>([1, 2, 3], [4, 5, 6]),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3, 4, 5, 6]))
    ),
    Suite.test(
      "concat first empty",
      Array.concat<Int>([], [4, 5, 6]),
      M.equals(T.array<Int>(T.intTestable, [4, 5, 6]))
    ),
    Suite.test(
      "concat second empty",
      Array.concat<Int>([1, 2, 3], []),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3]))
    ),
    Suite.test(
      "concat both empty",
      Array.concat<Int>([], []),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "sort",
      Array.sort([2, 3, 1], Nat.compare),
      M.equals(T.array<Nat>(T.natTestable, [1, 2, 3]))
    ),
    Suite.test(
      "sort empty array",
      Array.sort([], Nat.compare),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "sort already sorted",
      Array.sort([1, 2, 3, 4, 5], Nat.compare),
      M.equals(T.array<Nat>(T.natTestable, [1, 2, 3, 4, 5]))
    ),
    Suite.test(
      "sort repeated elements",
      Array.sort([2, 2, 2, 2, 2], Nat.compare),
      M.equals(T.array<Nat>(T.natTestable, [2, 2, 2, 2, 2]))
    ),
    Suite.test(
      "reverse",
      Array.reverse<Nat>([0, 1, 2, 2, 3]),
      M.equals(T.array<Nat>(T.natTestable, [3, 2, 2, 1, 0]))
    ),
    Suite.test(
      "reverse empty",
      Array.reverse<Nat>([]),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "reverse singleton",
      Array.reverse<Nat>([0]),
      M.equals(T.array<Nat>(T.natTestable, [0]))
    ),
    Suite.test(
      "map",
      Array.map<Nat, Bool>([1, 2, 3], func x = x % 2 == 0),
      M.equals(T.array<Bool>(T.boolTestable, [false, true, false]))
    ),
    Suite.test(
      "map empty",
      Array.map<Nat, Bool>([], func x = x % 2 == 0),
      M.equals(T.array<Bool>(T.boolTestable, []))
    ),
    Suite.test(
      "filter",
      Array.filter<Nat>([1, 2, 3, 4, 5, 6], func x = x % 2 == 0),
      M.equals(T.array<Nat>(T.natTestable, [2, 4, 6]))
    ),
    Suite.test(
      "filter empty",
      Array.filter<Nat>([], func x = x % 2 == 0),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "mapEntries",
      Array.mapEntries<Nat, Nat>([1, 2, 3], func(x, i) = x + i),
      M.equals(T.array<Nat>(T.natTestable, [1, 3, 5]))
    ),
    Suite.test(
      "mapEntries empty",
      Array.mapEntries<Nat, Nat>([], func(x, i) = x + i),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "filterMap",
      Array.filterMap<Nat, Nat>([1, 2, 3, 4, 5, 6], func x { if (x % 2 == 0) ?x else null }),
      M.equals(T.array<Nat>(T.natTestable, [2, 4, 6]))
    ),
    Suite.test(
      "filterMap keep all",
      Array.filterMap<Nat, Nat>([1, 2, 3], func x = ?x),
      M.equals(T.array<Nat>(T.natTestable, [1, 2, 3]))
    ),
    Suite.test(
      "filterMap keep none",
      Array.filterMap<Nat, Nat>([1, 2, 3], func _ = null),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "filterMap empty",
      Array.filterMap<Nat, Nat>([], func x { if (x % 2 == 0) ?x else null }),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "mapResult",
      Array.mapResult<Int, Nat, Text>(
        [1, 2, 3],
        func x { if (x >= 0) { #ok(Int.abs x) } else { #err "error message" } }
      ),
      M.equals(T.result<[Nat], Text>(T.arrayTestable(T.natTestable), T.textTestable, #ok([1, 2, 3])))
    ),
    Suite.test(
      "mapResult fail first",
      Array.mapResult<Int, Nat, Text>(
        [-1, 2, 3],
        func x { if (x >= 0) { #ok(Int.abs x) } else { #err "error message" } }
      ),
      M.equals(T.result<[Nat], Text>(T.arrayTestable(T.natTestable), T.textTestable, #err "error message"))
    ),
    Suite.test(
      "mapResult fail last",
      Array.mapResult<Int, Nat, Text>(
        [1, 2, -3],
        func x { if (x >= 0) { #ok(Int.abs x) } else { #err "error message" } }
      ),
      M.equals(T.result<[Nat], Text>(T.arrayTestable(T.natTestable), T.textTestable, #err "error message"))
    ),
    Suite.test(
      "mapResult empty",
      Array.mapResult<Nat, Nat, Text>(
        [],
        func x = #ok x
      ),
      M.equals(T.result<[Nat], Text>(T.arrayTestable(T.natTestable), T.textTestable, #ok([])))
    ),
    Suite.test(
      "flatMap",
      Array.flatMap<Int, Int>([0, 1, 2], func x = [x, -x].vals()),
      M.equals(T.array<Int>(T.intTestable, [0, 0, 1, -1, 2, -2]))
    ),
    Suite.test(
      "flatMap empty",
      Array.flatMap<Int, Int>([], func x = [x, -x].vals()),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "flatMap mix",
      Array.flatMap<Nat, Nat>(
        [1, 2, 1, 2, 3],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, [0, 0, 1, 0, 0, 1, 0, 1, 2]))
    ),
    Suite.test(
      "flatMap mix empty right",
      Array.flatMap<Nat, Nat>(
        [0, 1, 2, 0, 1, 2, 3, 0],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, [0, 0, 1, 0, 0, 1, 0, 1, 2]))
    ),
    Suite.test(
      "flatMap mix empties right",
      Array.flatMap<Nat, Nat>(
        [0, 1, 2, 0, 1, 2, 3, 0, 0, 0],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, [0, 0, 1, 0, 0, 1, 0, 1, 2]))
    ),
    Suite.test(
      "flatMap mix empty left",
      Array.flatMap<Nat, Nat>(
        [0, 1, 2, 0, 1, 2, 3],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, [0, 0, 1, 0, 0, 1, 0, 1, 2]))
    ),
    Suite.test(
      "flatMap mix empties left",
      Array.flatMap<Nat, Nat>(
        [0, 0, 0, 1, 2, 0, 1, 2, 3],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, [0, 0, 1, 0, 0, 1, 0, 1, 2]))
    ),
    Suite.test(
      "flatMap mix empties middle",
      Array.flatMap<Nat, Nat>(
        [0, 1, 2, 0, 0, 0, 1, 2, 3],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, [0, 0, 1, 0, 0, 1, 0, 1, 2]))
    ),
    Suite.test(
      "flatMap mix empties",
      Array.flatMap<Nat, Nat>(
        [0, 0, 0],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "flatMap mix empty",
      Array.flatMap<Nat, Nat>(
        [],
        func n = Array.tabulate<Nat>(n, func i = i).vals()
      ),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "foldLeft",
      Array.foldLeft<Text, Text>(["a", "b", "c"], "", Text.concat),
      M.equals(T.text("abc"))
    ),
    Suite.test(
      "foldLeft empty",
      Array.foldLeft<Text, Text>([], "base", Text.concat),
      M.equals(T.text("base"))
    ),
    Suite.test(
      "foldRight",
      Array.foldRight<Text, Text>(["a", "b", "c"], "", func(x, acc) = acc # x),
      M.equals(T.text("cba"))
    ),
    Suite.test(
      "foldRight empty",
      Array.foldRight<Text, Text>([], "base", Text.concat),
      M.equals(T.text("base"))
    ),
    Suite.test(
      "flatten",
      Array.flatten<Int>([[1, 2, 3], [], [1]]),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3, 1]))
    ),
    Suite.test(
      "flatten empty start",
      Array.flatten<Int>([[], [1, 2, 3], [], [1]]),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3, 1]))
    ),
    Suite.test(
      "flatten empty end",
      Array.flatten<Int>([[1, 2, 3], [], [1], []]),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3, 1]))
    ),
    Suite.test(
      "flatten singleton",
      Array.flatten<Int>([[1, 2, 3]]),
      M.equals(T.array<Int>(T.intTestable, [1, 2, 3]))
    ),
    Suite.test(
      "flatten singleton empty",
      Array.flatten<Int>([[]]),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "flatten empty",
      Array.flatten<Int>([]),
      M.equals(T.array<Int>(T.intTestable, []))
    ),
    Suite.test(
      "make",
      Array.singleton<Int>(0),
      M.equals(T.array<Int>(T.intTestable, [0]))
    ),
    Suite.test(
      "values",
      do {
        var sum = 0;
        for (x in Array.values([1, 2, 3])) {
          sum += x
        };
        sum
      },
      M.equals(T.nat(6))
    ),
    Suite.test(
      "values empty",
      do {
        var sum = 0;
        for (x in Array.values([])) {
          sum += x
        };
        sum
      },
      M.equals(T.nat(0))
    ),
    Suite.test(
      "keys",
      do {
        var sum = 0;
        for (x in Array.keys([1, 2, 3])) {
          sum += x
        };
        sum
      },
      M.equals(T.nat(3))
    ),
    Suite.test(
      "keys empty",
      do {
        var sum = 0;
        for (x in Array.keys([])) {
          sum += x
        };
        sum
      },
      M.equals(T.nat(0))
    ),
    Suite.test(
      "sliceToArray if including entire array",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], 0, 5),
      M.equals(T.array(T.natTestable, [2, 4, 6, 8, 10]))
    ),
    Suite.test(
      "sliceToArray if including all but last index",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], 0, -1),
      M.equals(T.array(T.natTestable, [2, 4, 6, 8]))
    ),
    Suite.test(
      "sliceToArray if including all but first index",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], 1, 5),
      M.equals(T.array(T.natTestable, [4, 6, 8, 10]))
    ),
    Suite.test(
      "sliceToArray if including middle of array",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], 1, 4),
      M.equals(T.array(T.natTestable, [4, 6, 8]))
    ),
    Suite.test(
      "sliceToArray if including middle of array (negative indices)",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], -4, -1),
      M.equals(T.array(T.natTestable, [4, 6, 8]))
    ),
    Suite.test(
      "sliceToArray if including start, but not end of array",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], 0, -2),
      M.equals(T.array(T.natTestable, [2, 4, 6]))
    ),
    Suite.test(
      "sliceToArray if including end, but not start of array",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], 2, 5),
      M.equals(T.array(T.natTestable, [6, 8, 10]))
    ),
    Suite.test(
      "sliceToArray if including end, but not start of array (negative indices)",
      Array.sliceToArray<Nat>([2, 4, 6, 8, 10], -3, 5),
      M.equals(T.array(T.natTestable, [6, 8, 10]))
    ),
    Suite.test(
      "nextIndexOf start",
      Array.nextIndexOf<Char>('c', ['c', 'o', 'f', 'f', 'e', 'e'], 0, Char.equal),
      M.equals(T.optional(T.natTestable, ?0))
    ),
    Suite.test(
      "nextIndexOf not found from offset",
      Array.nextIndexOf<Char>('c', ['c', 'o', 'f', 'f', 'e', 'e'], 1, Char.equal),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "nextIndexOf middle",
      Array.nextIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 0, Char.equal),
      M.equals(T.optional(T.natTestable, ?2))
    ),
    Suite.test(
      "nextIndexOf repeat",
      Array.nextIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 2, Char.equal),
      M.equals(T.optional(T.natTestable, ?2))
    ),
    Suite.test(
      "nextIndexOf start from the middle",
      Array.nextIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 3, Char.equal),
      M.equals(T.optional(T.natTestable, ?3))
    ),
    Suite.test(
      "nextIndexOf not found",
      Array.nextIndexOf<Char>('g', ['c', 'o', 'f', 'f', 'e', 'e'], 0, Char.equal),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "nextIndexOf index out of bounds",
      Array.nextIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 100, Char.equal),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),

    Suite.test(
      "prevIndexOf first",
      Array.prevIndexOf<Char>('c', ['c', 'o', 'f', 'f', 'e', 'e'], 6, Char.equal),
      M.equals(T.optional(T.natTestable, ?0))
    ),
    Suite.test(
      "prevIndexOf last",
      Array.prevIndexOf<Char>('e', ['c', 'o', 'f', 'f', 'e', 'e'], 6, Char.equal),
      M.equals(T.optional(T.natTestable, ?5))
    ),
    Suite.test(
      "prevIndexOf middle",
      Array.prevIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 6, Char.equal),
      M.equals(T.optional(T.natTestable, ?3))
    ),
    Suite.test(
      "prevIndexOf start from the middle",
      Array.prevIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 3, Char.equal),
      M.equals(T.optional(T.natTestable, ?2))
    ),
    Suite.test(
      "prevIndexOf existing not found",
      Array.prevIndexOf<Char>('f', ['c', 'o', 'f', 'f', 'e', 'e'], 2, Char.equal),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "prevIndexOf not found",
      Array.prevIndexOf<Char>('g', ['c', 'o', 'f', 'f', 'e', 'e'], 6, Char.equal),
      M.equals(T.optional(T.natTestable, null : ?Nat))
    ),
    Suite.test(
      "Iter conversions",
      Array.fromIter<Nat>(Array.values([1, 2, 3])),
      M.equals(T.array<Nat>(T.natTestable, [1, 2, 3]))
    ),
    Suite.test(
      "Iter conversions empty",
      Array.fromIter<Nat>(Array.values([])),
      M.equals(T.array<Nat>(T.natTestable, []))
    ),
    Suite.test(
      "enumerate empty array",
      do {
        var hasItem = false;
        for (_ in Array.enumerate([])) {
          hasItem := true
        };
        hasItem
      },
      M.equals(T.bool(false))
    ),
    Suite.test(
      "enumerate non-empty array",
      do {
        var sum = 0;
        for ((i, x) in Array.enumerate([10, 20, 30])) {
          sum += i + x
        };
        sum // Should be (0+10) + (1+20) + (2+30) = 63
      },
      M.equals(T.nat(63))
    ),
    Suite.test(
      "enumerate preserves indices",
      do {
        var indices = "";
        for ((i, _) in Array.enumerate(['a', 'b', 'c'])) {
          indices #= Nat.toText(i)
        };
        indices
      },
      M.equals(T.text("012"))
    ),
    Suite.test(
      "enumerate preserves values",
      do {
        var values = "";
        for ((_, x) in Array.enumerate(['a', 'b', 'c'])) {
          values #= Char.toText(x)
        };
        values
      },
      M.equals(T.text("abc"))
    )
  ]
);

Suite.run(suite)
