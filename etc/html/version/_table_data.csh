echo "<tr class=data>"
echo "<td class=col1>"
echo "<a href=$item_name/index.htm>"
echo "$item_name"
echo "</a>"
echo "</td>"

echo "<td class=col2>"
echo "<object name=readme type=text/html data=$item_name/.dvc/README width=300></object>"
echo "</td>"

foreach dqi ($container_dqi)
  echo "<td width=10>"
  dvc_get_dqi --root $item_data $dqi
  echo "</td>"
end

echo "</tr>"
