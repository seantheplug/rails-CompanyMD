const toggler = () => {
    const reports = document.querySelector('#reports');
    const reportsContent = document.querySelector('.reports');
    const statement = document.querySelector('#statement');
    const statementContent = document.querySelector('#financials');
    const news = document.querySelector('#news');
    const newsContent = document.querySelector('#news-container');
    const buttons = [reports, statement, news];

    reports.addEventListener("click", () => {
        reportsContent.style.display = "block";
        newsContent.style.display = "none";
        statementContent.style.display = "none";
    });

    statement.addEventListener("click", () => {
        statementContent.style.display = "block";
        reportsContent.style.display = "none";
        newsContent.style.display = "none";
    });
    
    news.addEventListener("click", () => {
        newsContent.style.display = "block";
        reportsContent.style.display = "none";
        statementContent.style.display = "none";
    });
}

export { toggler };