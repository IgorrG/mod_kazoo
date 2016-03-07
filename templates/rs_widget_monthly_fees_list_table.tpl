<table class="table table-condensed table-centered">
    <thead>
        <tr><th colspan="3">
            {% wire id="arrows_"++#rsmfeesid type="click"
                    action={ toggle target="rs_monthly_fees_lists_table_opened" }
                    action={ toggle target=#mytr }
                    action={ toggle target="arrow_right_"++#rsmfeesid }
                    action={ toggle target="arrow_down_"++#rsmfeesid }
                    action={ postback postback={trigger_innoui_widget arg="rs_monthly_fees_lists_table_opened" } delegate="mod_kazoo" }
            %}
              <span id="arrows_{{ #rsmfeesid }}" style="cursor: pointer; padding-left: 0.7em;">
                <i id="arrow_right_{{ #rsmfeesid }}" style="{% if m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}" 
                                                class="arrowpad fa fa-arrow-circle-right"></i>
                <i id="arrow_down_{{ #rsmfeesid }}" style="{% if not m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}" 
                                               class="arrowpad fa fa-arrow-circle-down"></i>
              </span>
               {_ Monthly fees _}
            </th>
        </tr>
        <tr id="{{ #mytr }}" style="{% if not m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}"><th colspan="3"></th></tr>
    </thead>
</table>
<span id="rs_monthly_fees_lists_table_opened" style="{% if not m.kazoo[{ui_element_opened element="rs_monthly_fees_lists_table_opened"}] %}display: none;{% endif %}">
<table id="rs_monthly_fees_lists_table" class="table display table-striped table-condensed">
    <thead>
        <tr>
            <th class="td-center">{_ Date _}</th>
            <th class="td-center">{_ Description _}</th>
            <th class="td-center">{_ Sum _}</th>
        </tr>
    </thead>
    <tbody>
            {% for transaction in m.kazoo[{kz_list_transactions account_id=account_id payments_month_chosen=payments_month_chosen type="debit"}] %}
                <tr id={{ transaction["id"] }} {% if transaction["subscription_id"] %}style="cursor: pointer;"{% endif %}>
                    <td class="td-center">
                      {{ transaction["created"]|inno_timestamp_to_date }}
                      {{ transaction["created"]|inno_timestamp_to_date:"show_tz_name" }}
                    </td>
                    <td class="td-center">
                      {% if transaction["description"] %}
                        {{ transaction["description"] }}
                      {% else %}
                        {{ transaction["reason"] }}
                      {% endif %}
                    </td>
                    <td class="td-center">
                      {{ m.config.mod_kazoo.local_currency_sign.value }}{{ transaction["amount"] }}
                    </td>
                </tr>
            {% endfor %}
    </tbody>
</table>

{% javascript %}
//var initSearchParam = $.getURLParam("filter");
var oTable = $('#rs_monthly_fees_lists_table').dataTable({
"pagingType": "simple",
"bFilter" : true,
"aaSorting": [[ 0, "desc" ]],
"aLengthMenu" : [[5, 15, -1], [5, 15, "All"]],
"iDisplayLength" : 5,
"oLanguage" : {
        "sInfoThousands" : " ",
        "sLengthMenu" : "_MENU_ {_ lines per page _}",
        "sSearch" : "{_ Filter _}:",
        "sZeroRecords" : "{_ Nothing found, sorry _}",
        "sInfo" : "{_ Showing _} _START_ {_ to _} _END_ {_ of _} _TOTAL_ {_ entries _}",
        "sInfoEmpty" : "{_ Showing 0 entries _}",
        "sInfoFiltered" : "({_ Filtered from _} _MAX_ {_ entries _})",
        "oPaginate" : {
                "sPrevious" : "{_ Back _}",
                "sNext" : "{_ Forward _}"
        }
},

});

{% endjavascript %}

</span>
