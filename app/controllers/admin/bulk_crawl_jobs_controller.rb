module Admin
  class BulkCrawlJobsController < Admin::ApplicationController
    def create
      bulk_crawl_request = BulkCrawlRequest.find(params[:bulk_crawl_request_id])
      CrawlWebPagesJob.perform_later(bulk_crawl_request.id)
      redirect_to admin_bulk_crawl_request_path(bulk_crawl_request), notice: "CrawlWebPagesJob job has been triggered."
    end
  end
end
