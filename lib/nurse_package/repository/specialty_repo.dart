

import 'package:doctor_v2/nurse_package/model/specialty_model.dart';

class SpecialtyRepository{
  List<Map<String, dynamic>> _specialties =  [
    {
      "id": "1",
      "title": "  Licensed Practical Nurse",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "2",
      "title": " Registered Nurse (RN)",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "3",
      "title": "  Clinical Nurse Specialist (CNS)",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "4",
      "title": "   Critical Care Nurse\r\n",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "5",
      "title": "Emergency Nurse",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "6",
      "title": "Family Nurse Practitioner",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "7",
      "title": " Geriatric Nurse",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "8",
      "title": "Mental Health Nurse",
      "created_at": "2021-09-20 20:56:23"
    },
    {
      "id": "9",
      "title": " Perioperative Nurse",
      "created_at": "2021-09-20 20:56:23"
    }
  ];

  List<Map<String, dynamic>> getAll() => _specialties;

  List<SpecialtyModel> getSpecialties() => _specialties
      .map((map) => SpecialtyModel.fromJson(map))
      .toList();
}