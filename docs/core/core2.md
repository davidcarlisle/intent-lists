---
title: Core Concept List
---

# Core Concept List


## Matching the List

1. A intent processor should match a system-specifed list of known concept names.
The list should include all the entries from the **core** list below.

2. Optionally intents may be defaulted based on the available content, so `<mo>=</mo>` may default to
`<mo intent="equals">=</mo>` or `<msup><mi>x</mi><mn>2</mn></msup>` may default to
`<msup intent="power($x,$n)"><mi arg="x">x</mi><mn arg="n">2</mn></msup>`
Defaulting rules and options to control them to be specifed elsewhere, and are likely to be system specific.

3. An intent term matches a row in the table if the concept name,
arity and property _all_ match.  Any intent literal that does not match is
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

<div class="language-switch">
  <select class="language-switch__select" id="myList" multiple>
     <!-- Loop over languages in _data/languages.yml -->
    {%- for language in site.data.languages -%}
        {% assign lang = language.language-code %}
        <option
	  {% if lang == "en" %}
          selected
          {% endif %}
          value="{{lang}}">
            {{ language.label-regional }}
            <!-- Ensures the translation of English is not displayed -->
            {% if lang != "en" %}
              ({{language.label-english}})
            {% endif %}
        </option>
    {%- endfor -%}
  </select>
</div>

<select id="LangSelect" multiple>
  <option value="4" selected>English (en)</option>
  <option value="5">French (fr)</option>
</select>

<style id="langcss">
  tr > *:nth-child(5) {display:none}
</style>


<table>
<thead>
<tr>
<th>Concept</th>
<th>Arity</th>
<th>Property</th>
<th>Condition</th>
{%- for language in site.data.languages -%}
<th>Speech Template ({{language.language-code}})</th> 
{%- endfor -%}
<th>Comments</th>
</tr>
</thead>
<tbody>
{%- for c in site.data.core -%}
<tr>
<td>{{c.concept}}</td>
<td>{{c.arity}}</td>
<td>{{c.property}}</td>
{%- for language in site.data.languages -%}
{%- if c[language.language-code] == "" -%}
<td>{{c.en}} ({{language.language-code}})</td>
{%- else -%}
<td>{{c[language.language-code]}}</td>
{% endif %}
{%- endfor -%}
<td>{{c.comment}}</td>
</tr>
{%- endfor -%}
</tbody>
</table>


### Key

| Entry | Meaning |
| ---- | ---- |
| `*` | property default if no  fixity`:` property given |
| _th_  | suitable ordinal indicator, so `st`  `nd` `rd` or `th` in English. |

----



<script>
      var LangSelect = document.getElementById('LangSelect');
      var LangCss = document.getElementById('langcss');
      LangSelect.onchange = (event) => {
	 LangCss.textContent='';
     for (var i=0, iLen=LangSelect.options.length; i<iLen; i++) {
    opt = LangSelect.options[i];
    if (opt.selected) {
    } else {
	LangCss.textContent= LangCss.textContent + "tr > *:nth-child(" + opt.value + ") {display:none}";
    }
     }
 }
</script>

