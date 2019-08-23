module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def create_stock_price_chart_index(company, time_series, outputsize = nil)
    if outputsize.nil?
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_#{time_series.upcase}&symbol=#{company.ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    else
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_#{time_series.upcase}&symbol=#{company.ticker}&outputsize=#{outputsize}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    end

    demo_url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo"
    json = open(url).read
    price_info = JSON.parse(json)
    time = []
    close_price = []
    price_info["Time Series (#{time_series.capitalize})"].each do |key, value|
      time << key
      close_price << value["4. close"].to_f
    end
    @min_price << close_price.min
    company.update!(times: time, prices: close_price)
    price_data_array = []
    close_price.each_with_index do |price, index|
      price_data_array << [time[index], price]
    end
    return price_data_array.reverse!
  end

  def create_stock_price_chart_show(company, time_series, outputsize = nil)
    if outputsize.nil?
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_#{time_series.upcase}&symbol=#{company.ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    else
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_#{time_series.upcase}&symbol=#{company.ticker}&outputsize=#{outputsize}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    end

    demo_url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo"
    json = open(url).read
    price_info = JSON.parse(json)
    time = []
    close_price = []
    price_info["Time Series (#{time_series.capitalize})"].each do |key, value|
      time << key
      close_price << value["4. close"].to_f
    end
    @min_price << close_price.min
    # company.update!(times: time, prices: close_price)
    price_data_array = []
    close_price.each_with_index do |price, index|
      price_data_array << [time[index], price]
    end
    return price_data_array.reverse!
  end


  def quote_endpoint(ticker)
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    json = open(url).read
    price_info = JSON.parse(json)["Global Quote"]
    info_hash = Hash.new
    info_hash[:ticker] = ticker
    info_hash[:symbol] = price_info["01. symbol"]
    info_hash[:open] = price_info["02. open"].to_f.round(2)
    info_hash[:high] = price_info["03. high"].to_f.round(2)
    info_hash[:low] = price_info["04. low"].to_f.round(2)
    info_hash[:price] = price_info["05. price"].to_f.round(2)
    info_hash[:volume] = price_info["06. volume"]
    info_hash[:latest] = price_info["07. trading day"]
    info_hash[:previous] = price_info["08. close"]
    info_hash[:change] = price_info["09. change"]
    info_hash[:change_percent] = price_info["10. change percent"].to_f.round(2)
    return info_hash
  end

  def market_index_quote_endpoint(market_index)
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{market_index.ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    json = open(url).read
    price_info = JSON.parse(json)["Global Quote"]
    market_index.update!(price: price_info["05. price"].to_f.round(2),
    high: price_info["03. high"].to_f.round(2), low: price_info["04. low"].to_f.round(2),
    change: price_info["09. change"].to_f.round(2), change_percent: price_info["10. change percent"].to_f.round(2))
  end

  def roc_chart(ticker, interval, time_period, series_type)
    # url = "https://www.alphavantage.co/query?function=ROC&symbol=#{ticker}&interval=#{interval}&time_period=#{time_period}&series_type=#{series_type}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    url = "https://www.alphavantage.co/query?function=ROC&symbol=MSFT&interval=weekly&time_period=10&series_type=close&apikey=demo"
    json = open(url).read
    price_info = JSON.parse(json)

    time = []
    tech_indicator = []
    price_info["Technical Analysis: ROC"].each do |key, value|
      time << key
      tech_indicator << value["ROC"].to_f
    end
    indicator_data_array = []
    tech_indicator.each_with_index do |indicator, index|
      indicator_data_array << [time[index], indicator]
    end
    return indicator_data_array
  end

  def search_company(keyword)
    url = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=#{keyword}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    json = open(url).read
    search_result = JSON.parse(json)
    search_result["bestMatches"]
  end

  def get_company_name(query)
    url = "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=#{query}&region=1&lang=en"
    json = open(url).read
    company = JSON.parse(json)
    name = company["ResultSet"]["Result"][0]["name"]
  end

  def google_search(query)
    url = "https://kgsearch.googleapis.com/v1/entities:search?query=#{query}&key=#{ENV['GOOGLE_SEARCH_KEY']}&limit=1&indent=True"
    json = open(url).read
    company = JSON.parse(json)
    company_info = company["itemListElement"][0]["result"]

    info_hash = Hash.new
    info_hash[:description] = company_info["detailedDescription"]["articleBody"]
    info_hash[:img] = company_info["image"]["contentUrl"]
    return info_hash
  end

  def company_news(query)
    sources = ["bloomberg", "reuters", "fortune", "cnn"]
    array = []

    sources.each do |source|
      url = "https://newsapi.org/v2/everything?q=#{query}&sources=#{source}&apiKey=#{ENV['NEWS_API_KEY']}"
      json = open(url).read
      news_result = JSON.parse(json)
      array << news_result["articles"]
    end

    news_array = []

    array.each do |source|
      source.each do |article|
        news_array << [article["source"]["name"], article["title"], article["description"], article["url"]]
      end
    end
    news_array
  end

  def key_stat(ticker, stat)
    # stat examples: marketcap, peRatio, employees, dividendYield
    url = "https://cloud.iexapis.com/stable/stock/#{ticker}/stats/#{stat}?token=#{ENV['IEX_API_KEY']}"
    begin
      json = open(url)
    rescue
      return nil
    else
      json = open(url).read
      JSON.parse(json)
    end
  end
end

# https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo -> daily
# https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo -> weekly
# https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&outputsize=full&apikey=demo -> output
# https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo -> quote_endpoint
# https://www.alphavantage.co/query?function=SECTOR&apikey=demo -> SECTOR
# https://www.alphavantage.co/query?function=ROC&symbol=MSFT&interval=weekly&time_period=10&series_type=close&apikey=demo -> roc
