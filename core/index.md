
## Core list

| concept   | arity | hint     | speech template (en)                 | Comments     |
| ----      | ----  | ----     | ----                                 |              |
| power     | 2     | infix*   | IF $2=2<br> $1 squared               |              |
|           |       |          | IF $2=3<br> $1 cubed                 |              |
|           |       |          | IF $2=_n_<br> $1 to the $2_th_ power |              |
| equals    | 2     | infix*   | $1 equals $2                         |              |
|           |       |          | $1 is equal to $2                    |              |
|           |       | function | equal to $1, $2                      |              |
| factorial | 1     | postfix* | $1 factoral                          |              |
|           |       | function | factorial of $1                      |              |
| ⋮ | ⋮ | ⋮ | ⋮ | More to be added |

-----

### Key

| entry | meaning |
| ---- | ---- |
| `*` | hint default if no `@` hint given |
| _th_  | suitable ordinal indicator, so `st`  `nd` `rd` or `th` in English. |


## Matching the list

1. A intent processor should match a system-specifed list of known concept names.
The list should include all the entries from the **core** list above.

2. Optionally intents may be defaulted based on the available content, so `<mo>=</mo>` may default to
`<mo intent="equals">=</mo>` or `<msup><mi>x</mi><mn>2</mn></msup>` may default to
`<msup intent="power($x,$n)><mi arg="x">x</mi><mn arg="n">2</mn></msup>`
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