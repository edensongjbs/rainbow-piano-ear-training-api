class ChordsController < ApplicationController
    def index
        render json: Chord.all
    end
end
