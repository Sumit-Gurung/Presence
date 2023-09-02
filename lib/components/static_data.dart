const String reportOfAttendeesInMyGroups = '''[
    {
        "group": {
            "id": 2,
            "name": "Science XII",
            "totalStudent": 21
        },
        "attendance": [
            {
                "date": "2023-07-07",
                "presentStudent": 3
            },
            {
                "date": "2023-07-09",
                "presentStudent": 2
            },
            {
                "date": "2023-07-13",
                "presentStudent": 2
            },
            {
                "date": "2023-07-14",
                "presentStudent": 1
            },
            {
                "date": "2023-08-21",
                "presentStudent": 2
            },
            {
                "date": "2023-08-27",
                "presentStudent": 3
            },
            {
                "date": "2023-08-28",
                "presentStudent": 2
            },
            {
                "date": "2023-08-29",
                "presentStudent": 9
            },
            {
                "date": "2023-08-31",
                "presentStudent": 1
            },
            {
                "date": "2023-09-01",
                "presentStudent": 2
            },
            {
                "date": "2023-09-02",
                "presentStudent": 6
            }
        ]
    },
    {
        "group": {
            "id": 3,
            "name": "sumit group",
            "totalStudent": 7
        },
        "attendance": [
            {
                "date": "2023-07-09",
                "presentStudent": 1
            },
            {
                "date": "2023-07-14",
                "presentStudent": 1
            },
            {
                "date": "2023-08-27",
                "presentStudent": 1
            },
            {
                "date": "2023-08-31",
                "presentStudent": 2
            }
        ]
    },
    {
        "group": {
            "id": 5,
            "name": "sumitgib",
            "totalStudent": 5
        },
        "attendance": [
          {
                "date": "2023-08-27",
                "presentStudent": 4
            },
            {
                "date": "2023-08-28",
                "presentStudent": 3
            },
            {
                "date": "2023-08-29",
                "presentStudent": 2
            },
            {
                "date": "2023-08-31",
                "presentStudent": 6
            },
            {
                "date": "2023-09-01",
                "presentStudent": 7
            },
            {
                "date": "2023-09-02",
                "presentStudent": 3
            }
        ]
    },
    {
        "group": {
            "id": 17,
            "name": "nursing",
            "totalStudent": 6
        },
        "attendance": [
            {
                "date": "2023-07-09",
                "presentStudent": 2
            }
        ]
    },
    {
        "group": {
            "id": 18,
            "name": "errr",
            "totalStudent": 6
        },
        "attendance": [
          {
                "date": "2023-08-27",
                "presentStudent": 3
            },
            {
                "date": "2023-08-28",
                "presentStudent": 2
            },
            {
                "date": "2023-08-29",
                "presentStudent": 2
            },
            {
                "date": "2023-08-31",
                "presentStudent": 1
            },
            {
                "date": "2023-09-01",
                "presentStudent": 3
            },
            {
                "date": "2023-09-02",
                "presentStudent": 6
            }
        ]
    },
    {
        "group": {
            "id": 19,
            "name": "loppp",
            "totalStudent": 2
        },
        "attendance": []
    },
    {
        "group": {
            "id": 20,
            "name": "ftgvedrr",
            "totalStudent": 6
        },
        "attendance": []
    },
    {
        "group": {
            "id": 21,
            "name": "k cha",
            "totalStudent": 3
        },
        "attendance": []
    },
    {
        "group": {
            "id": 23,
            "name": "uuf",
            "totalStudent": 4
        },
        "attendance": []
    },
    {
        "group": {
            "id": 24,
            "name": "hovuo",
            "totalStudent": 3
        },
        "attendance": []
    },
    {
        "group": {
            "id": 25,
            "name": "hovuogiy",
            "totalStudent": 3
        },
        "attendance": []
    },
    {
        "group": {
            "id": 26,
            "name": "hovuogiygugucy",
            "totalStudent": 2
        },
        "attendance": []
    },
    {
        "group": {
            "id": 27,
            "name": "wa",
            "totalStudent": 2
        },
        "attendance": []
    },
    {
        "group": {
            "id": 28,
            "name": "multiple attendee",
            "totalStudent": 4
        },
        "attendance": []
    },
    {
        "group": {
            "id": 29,
            "name": "kala ko lage",
            "totalStudent": 2
        },
        "attendance": []
    },
    {
        "group": {
            "id": 30,
            "name": "ty",
            "totalStudent": 0
        },
        "attendance": []
    },
    {
        "group": {
            "id": 31,
            "name": "ABCD",
            "totalStudent": 4
        },
        "attendance": []
    }
]''';

const String myAttendanceReport = '''
[
    {
        "group": {
            "id": 3,
            "name": "sumit group"
        },
        "totalDays": 4,
        "presentDays": 2
    },
    {
        "group": {
            "id": 17,
            "name": "nursing"
        },
        "totalDays": 9,
        "presentDays": 4
    },
    {
        "group": {
            "id": 18,
            "name": "errr"
        },
        "totalDays": 5,
        "presentDays": 3
    },
    {
        "group": {
            "id": 20,
            "name": "ftgvedrr"
        },
        "totalDays": 5,
        "presentDays": 2
    },
    {
        "group": {
            "id": 22,
            "name": "Presence Grp"
        },
        "totalDays": 0,
        "presentDays": 0
    },
    {
        "group": {
            "id": 24,
            "name": "hovuo"
        },
        "totalDays": 0,
        "presentDays": 0
    }
]
''';
