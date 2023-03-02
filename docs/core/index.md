# Core Concept List


## Matching the List

1. A intent processor should match a system-specifed list of known concept names.
The list should include all the entries from the **core** list below.

2. Optionally intents may be defaulted based on the available content, so `<mo>=</mo>` may default to
`<mo intent="equals">=</mo>` or `<msup><mi>x</mi><mn>2</mn></msup>` may default to
`<msup intent="power($x,$n)"><mi arg="x">x</mi><mn arg="n">2</mn></msup>`
Defaulting rules and options to control them to be specifed elsewhere, and are likely to be system specific.

3. An intent term matches a row in the table if the concept name,
arity and hint _all_ match.  Any intent literal that does not match is
not an error but is handled by the general rules for unknown concept
names (so treated as a literal). Note that unless the intent is
explicitly or implicitly (by expanding `$argref`) used as a function
head it will have arity 0.

4. The conditionals in the speech template should be constructed such that at least one row matches.
If more than one speech template matches a system specific choice should be taken.
The exact words in the speech templates are not normative so a system may have multiple possible wordings
controlled by the context, or by system option settings such as "Verbosity".

----

## Core List

| Concept   | Arity | Hint      | Speech Template (en)                 | Comments     |
| ----      | ----  | ----      | ----                                 | ----         |
| power     | 2     | infix*    | $1 squared [$2=2] <br> $1 cubed [$2=3] <br> $1 to the $2_th_ power             |              |
| equals    | 2     | infix*    | $1 equals $2  <br>   $1 is equal to $2                      |              |
| equals    | 2     | function  | equal to $1, $2                      |              |
| factorial | 1     | postfix*  | $1 factoral                          |              |
| factorial | 1     | function  | factorial of $1                      | This row could be deleted, as it follows from the default behaviour |
| sin       | 1     | prefix*   | sine $1                              |              |
| sin       | 1     | function  | sine of $1                           |              |
| log       | 2     | function* | log base $2 of $1                      |  arity 1 log(x)  needs no rule here |
| ln        | 1     | function* | natural log of $1 <br> log of $1  <br>  log base e of $1                   |  |
| ln        | 1     | prefix    | natural log $1  <br> log $1 <br> log base e $1                   |  |
| ⋮          | ⋮     | ⋮          | ⋮                                     | More to be added |



### Key

| Entry | Meaning |
| ---- | ---- |
| `*` | hint default if no `@` hint given |
| _th_  | suitable ordinal indicator, so `st`  `nd` `rd` or `th` in English. |

----
