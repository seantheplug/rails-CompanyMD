# Company MD

CompanyMD is a web application that aggregates a variety of financial data from market indices and individual stocks to yearly SEC report filings all in an user friendly format. It enables everyone from amateur to expert analyst to make informed choices regarding their investments. 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

To start using this web app download it first, then make sure you have ruby on rails set up on your local machine!!. (ps. use homebrew to install if you are a mac user)

Then go to the directory and create a .env file
copy and paste the below texts into the file and change the api key to your api key. All the API used here provide free subscuprtion, so go to their website and sign up for the key!!!!

```
ALPHA_VANTAGE_KEY=YOUR_KEY_HERE
GOOGLE_SEARCH_KEY=YOUR_KEY_HERE
NEWS_API_KEY=YOUR_KEY_HERE
IEX_API_KEY=YOUR_KEY_HERE
```

### Installing

After creating the .env file run the following commands in your terminal

Run 
```
rails db:create
rails db:seed
```

### Features
#### Your Dashboard where you can check the latest price of your choosen stocks and market index
![Alt text](app/assets/images/after_signing_up.png?raw=true "Title")#
#### Search you favrotie stock and added to your portfolio
![Alt text](app/assets/images/search_function.png?raw=true "Title")
#### Check your portfolio and make a simple comparison between your favorite stocks
![Alt text](app/assets/images/portfolio.png?raw=true "Title")
#### We provide intra day price and historical price
![Alt text](app/assets/images/price.png?raw=true "Title")
#### Check the latest news reagrding the stocks
![Alt text](app/assets/images/news.png?raw=true "Title")
#### Check the financial data and make a investment choice
![Alt text](app/assets/images/financial_data.png?raw=true "Title")
#### You can even download the data as excel file and make your own analysis on your local machine
![Alt text](app/assets/images/download.png?raw=true "Title")


### Built With

* [Ruby on rails]
* [Javascript]
* [HTML]
* [CSS]






 
