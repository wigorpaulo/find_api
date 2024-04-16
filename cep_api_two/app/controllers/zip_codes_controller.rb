class ZipCodesController < ApplicationController
  before_action :set_zip_code, only: %i[show]

  # GET /zip_codes/1
  def show
    zip_code_service = Api::FindZipCodeServices.find(params[:id])

    unless zip_code_service.present?
      return render json: { error: I18n.t('action.zip_code_not_found', zip_code: params[:id]) },
                    status: :bad_request
    end

    zip_code = ZipCode.create(zip_code: params[:id],
                              address: zip_code_service[:logradouro],
                              neighborhood: zip_code_service[:bairro],
                              city: zip_code_service[:localidade],
                              state: zip_code_service[:uf],
                              complement: zip_code_service[:complemento])

    create_user_request_zip_code(zip_code)

    render json: result(zip_code), status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_zip_code
    return render json: { error: I18n.t('parms.invalid') }, status: :bad_request unless params[:id].present?

    @zip_code = ZipCode.find_by(zip_code: params[:id])

    return unless @zip_code.present?

    create_user_request_zip_code(@zip_code)

    render json: result(@zip_code), status: :ok
  end

  def create_user_request_zip_code(zip_code)
    UserRequestZipCode.create(user: current_user, zip_code_id: zip_code.id)
  end

  def result(zip_code)
    {
      I18n.t('activerecord.attributes.zip_code.address').downcase => zip_code.address,
      I18n.t('activerecord.attributes.zip_code.neighborhood').downcase => zip_code.neighborhood,
      I18n.t('activerecord.attributes.zip_code.city').downcase => zip_code.city,
      I18n.t('activerecord.attributes.zip_code.state').downcase => zip_code.state,
      I18n.t('activerecord.attributes.zip_code.complement').downcase => zip_code.complement
    }
  end
end
