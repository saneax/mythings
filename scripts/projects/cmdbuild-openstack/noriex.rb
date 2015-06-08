require 'xmlsimple'
require 'pp'

hash = XmlSimple.xml_in('zbx_export_hosts.xml')

hash.each do |key,value|
  if key.is_array?
    puts "[This is an array][[#{key}]]\t=>\t#{pp value}\n"
  end
end


