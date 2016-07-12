require 'rails_helper'

RSpec.describe 'shared/_progressbar.html.slim' do
  it 'renders a danger bar when percent < 25' do
    render 'shared/progressbar', percent: 24

    expect(rendered).to have_css '.progress-bar.progress-bar-danger'
  end

  it 'renders a warning bar when percent < 50' do
    render 'shared/progressbar', percent: 49

    expect(rendered).to have_css '.progress-bar.progress-bar-warning'
  end

  it 'renders a success bar when percent < 75' do
    render 'shared/progressbar', percent: 74

    expect(rendered).to have_css '.progress-bar.progress-bar-success'
  end

  it 'renders a info bar when percent < 100' do
    render 'shared/progressbar', percent: 99

    expect(rendered).to have_css '.progress-bar.progress-bar-info'
  end

  it 'renders an animated info bar when percent == 100' do
    render 'shared/progressbar', percent: 100

    expect(rendered).to have_css '.progress-bar.progress-bar-info.progress-bar-striped.active'
  end
end
