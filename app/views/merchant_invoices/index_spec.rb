<h1>Invoice Index</h1>

<% if @invoices.any? %>
<ul>
  <% @invoices.each do |invoice| %>
    <li>
    <%= link_to invoice.id, "/merchants/:merchant_id/invoices" %>
    </li>
  <% end %>
</ul>
<% else %>
  <p>No Invoices Found</p>
<% end %>