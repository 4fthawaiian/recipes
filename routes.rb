get '/' do
  @pagesize = 10
  @offset = 0
  db = Zrecipes
  @offset = params[:offset] unless params[:offset].nil?

  @list = db.find_by_sql("select * from ZRECIPES limit #{@pagesize} offset #{@offset}")
  if params[:output].nil? || (params[:output] == "json")
    return @list.to_json
  elsif params[:output] == "html"
    # build the pagination links
    if @offset.to_i > 0
    prevlink =  "<a href=\"/?output=html\">First</a> | "
    prevlink += "<a href=\"/?output=html&offset=" + (@offset.to_i - @pagesize.to_i).to_s + "\">Previous</a>"
    else
    prevlink = "First | Previous"
    end

    if Zrecipes.count.to_i > (@list[0][:Z_PK].to_i + @pagesize.to_i)
    nextlink = "<a href=\"/?output=html&offset=" + (@offset.to_i + @pagesize.to_i).to_s + "\">Next</a>"
    else
    nextlink = "Next"
    end
    nextlink += " | <a href=\"/?output=html&offset=" + (Zrecipes.count.to_i - (Zrecipes.count.to_i % 10)).to_s + "\">Last</a>"

    @pagination = "#{prevlink}"
    @pagination += " | #{nextlink}"
    erb :recipes
  end
end

get '/recipe/:id' do
  @pagesize=params[:pagesize]
  db = Zrecipes
  if params[:id].nil?
  puts "<b> #{params[:id]} not found </b>"
  else
  @recipe = Zrecipes.find(params[:id])
  p @recipe[:ZNAME]
  erb :recipe
  end
end
