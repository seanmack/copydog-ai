module Admin
  class CrawlJobsController < Admin::ApplicationController
    def create
      crawl_request = CrawlRequest.find(params[:crawl_request_id])
      CrawlWebPageJob.perform_later(crawl_request.id)
      crawl_request.update(status: "in_progress")
      redirect_to admin_crawl_request_path(crawl_request), notice: "Crawl job has been triggered."
    end
  end
end
