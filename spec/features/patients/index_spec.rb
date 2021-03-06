require 'rails_helper'

RSpec.describe 'patients index', type: :feature do
  describe 'I see names of all patients ordered oldest to youngest' do
    before(:each) do
      @hospital1 = Hospital.create!(name: "Grey Sloan Memorial Hospital")
      @hospital2 = Hospital.create!(name: "Pacific Northwest General Hospital")
      @doc1 = @hospital1.doctors.create!(name: "Meredith Grey",
                              specialty: "General Surgery",
                              university: "Harvard University")
      @doc2 = @hospital2.doctors.create!(name: "Alex Karev",
                              specialty: "Pediatric Surgery",
                              university: "Johns Hopkins University")
      @doc3 = @hospital1.doctors.create!(name: "Miranda Bailey",
                              specialty: "General Surgery",
                              university: "Stanford University")

      @patient1 = Patient.create!(name: "Katie Bryce",
                              age: 24)
      @patient2 = Patient.create!(name: "Denny Duquette",
                              age: 39)
      @patient3 = Patient.create!(name: "Rebecca Pope",
                              age: 32)
      @patient4 = Patient.create!(name: "Zola  Shepherd",
                              age: 2)
      DoctorPatient.create!(doctor_id: @doc1.id, patient_id: @patient1.id )
      DoctorPatient.create!(doctor_id: @doc1.id, patient_id: @patient2.id )
      DoctorPatient.create!(doctor_id: @doc2.id, patient_id: @patient3.id )
      DoctorPatient.create!(doctor_id: @doc3.id, patient_id: @patient4.id )


    end
    it "see the list ordered by age " do
      expected_order = "Denny Duquette\nRebecca Pope Katie Bryce Zola Shepherd"

      visit "/patients/index"
      expect(page).to have_content("Welcome to Patients Index Page")
      expect(page).to have_content(expected_order)
      expect(page).to have_content(@patient1.name)
      expect(page).to have_content(@patient2.name)
      expect(page).to have_content(@patient3.name)
      expect(page).to have_content("Zola Shepherd")

    end
  end
end
