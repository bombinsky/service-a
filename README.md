# README

This README would normally document whatever steps are necessary to get the
application up and running.


## Useful commands

1. Run specs to check them

    ``` rspec ```

2. Run specs to check them

    ``` COVERAGE=true rspec ```
    ``` open tmp/reports/coverage/index.html ```

3. Launch console if needed

    ``` rails c ```

4. Check new code during development

    ``` pronto run -r=flay rails_best_practices reek rubocop brakeman -c origin/develop ```

5. Run pronto with cops on whole code like 
    
    ```pronto run --commit=$(git log --pretty=format:%H | tail -1)```


* Deployment instructions

WORKERS=ExternalUrlsRequestsProcessor,ExternalUrlsDeliveryRequestsProcessor rake sneakers:run

* ...
