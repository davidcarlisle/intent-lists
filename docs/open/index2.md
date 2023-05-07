
<style>
tr:target >td:first-child {border-left:solid thick black}
</style>

# Open Concept List
 
This open list sketch has been extracted from the google spreadsheet
and is not exactly in the format of the [core list](../core) but
hopefully close enough to be useful.

Entries in this list have no direct effect on the behavior of an
`intent` processor, however implementers are encouraged to record here
any concept names for which they implement custom rules. Names which
receive support in multiple implementations may be moved to the core
list.

The list may also be used as a reference for the intended meaning of intent
concept terms and so has many entries that do not require custom speech rules.


<table>
<thead>
<tr>
<th>Concept</th>
<th>Arity</th>
<th>Form/hint</th>
<th>Subject</th>
<th>Known notation</th>
<th>Sources</th>
<th>Alias</th>
</tr>
</thead>
<tbody>

{%- for c in site.data.open -%}

<tr id="{{c.concept}}{{c.arity}}{{c.form}}">
<td><a href="#{{c.concept}}{{c.arity}}{{c.form}}">{{c.concept}}</a></td>
<td>{{c.arity}}</td>
<td>{{c.form}}</td>
<td>{{c.area}}</td>
<td>{{c.notation}}</td>
{%- if c.url -%}
<td>{{c.url}}</td>
{%-endif -%}
{%- if c.urls -%}
<td
>{% for u un c.urls %}
<a href="{{u}}">{{u}}</a><br/>
{% endfor %}
</td>
{%-endif -%}
</tr>

{%- endfor -%}

</tbody>
</table>
