require_relative '../app/domain/use_cases/add_review'
require_relative '../app/adapters/presenters/review_presenter'
require_relative '../container'
require 'json'

module Routes
  class Reviews < Sinatra::Base

    post '/reviews' do
      data = json_params

      book_id  = data['book_id']
      user_id  = data['user_id']
      rating   = data['rating']
      comment  = data['comment']

      halt 400, error_json('book_id, user_id and rating are required') unless book_id && user_id && rating
      halt 400, error_json('rating must be between 1 and 5') unless (1..5).cover?(rating.to_i)

      use_case = AddReview.new(
        review_repo: Container.review_repo,
        book_repo:   Container.book_repo,
        user_repo:   Container.user_repo
      )

      review = use_case.execute(
        book_id: book_id,
        user_id: user_id,
        rating: rating.to_i,
        comment: comment
      )

      presenter = ReviewPresenter.new(review, Container.user_repo)
      status 201
      json_response(presenter.to_h)
    end

    private

    def json_params
      @json_params ||= begin
        JSON.parse(request.body.read)
      rescue
        {}
      end
    end

    def json_response(data)
      content_type :json
      data.to_json
    end

    def error_json(message)
      content_type :json
      { error: message }.to_json
    end
  end
end
