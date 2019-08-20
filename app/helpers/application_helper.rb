module ApplicationHelper
  def create_stock_price_chart(time_series, ticker, outputsize=nil)
    if outputsize.nil?
      url = "https://www.alphavantage.co/query?function=TIME_SERIES_#{time_series.upcase}&symbol=#{ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    else
        url = "https://www.alphavantage.co/query?function=TIME_SERIES_#{time_series.upcase}&symbol=#{ticker}&outputsize=#{outputsize}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    end
    json = open(url).read
    price_info= JSON.parse(json)
    @time = []
    @close_price = []
    price_info["Time Series (#{time_series.capitalize})"].each do |key, value|
    @time << key
    @close_price << value["4. close"].to_f
    end
    @price_data_array = [] 
    @close_price.each_with_index do |price, index| 
    @price_data_array << [@time[index], price]
    end
  end

  def quote_endpoint(ticker)
    url = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=#{ticker}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    json = open(url).read
    price_info= JSON.parse(json)
    @ticker = ticker
    @symbol = price_info["01. symbol"]
    @open = price_info["02. open"]
    @high = price_info["03. high"]
    @low = price_info["04. low"]
    @price = price_info["05. price"]
    @volume = price_info["06. volume"]
    @latest = price_info["07. trading day"]
    @previous = price_info["08. close"]
    @change = price_info["09. change"]
    @change_percent = price_info["10. change precent"]
  end

  def roc_chart(ticker, interval, time_period, series_type)
    url = "https://www.alphavantage.co/query?function=ROC&symbol=#{ticker}&interval=#{interval}&time_period=#{time_period}&series_type=#{series_type}&apikey=#{ENV['ALPHA_VANTAGE_KEY']}"
    json = open(url).read
    price_info= JSON.parse(json)
    @time = []
    @tech_indicator = []
    price_info["Technical Analysis: ROC"].each do |key, value|
    @time << key
    @tech_indicator << value["ROC"].to_f
    end
    @indicator_data_array = [] 
    @tech_indicator.each_with_index do |indicator, index| 
    @indicator_data_array << [@time[index], indicator]
    end 
  end
end

# https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo -> daily
# https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo -> weekly
# https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&outputsize=full&apikey=demo -> output 
# https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=demo -> quote_endpoint
# https://www.alphavantage.co/query?function=SECTOR&apikey=demo -> SECTOR
# https://www.alphavantage.co/query?function=ROC&symbol=MSFT&interval=weekly&time_period=10&series_type=close&apikey=demo -> roc 



