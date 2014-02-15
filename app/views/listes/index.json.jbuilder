json.array!(@listes) do |liste|
  json.extract! liste, :navn, :bane, :beskrivelse
  json.url liste_url(liste, format: :json)
end