#include<bits/stdc++.h>
using namespace std;

struct Student {
	int rollNo;
	string name;
	char division;
	string address;
};

void add() {
	Student s;

	cout << endl << "Enter the roll no of student : ";
	cin >> s.rollNo;

	cout << "Enter the name of student : ";
	cin >> s.name;

	cout << "Enter the division of student : ";
	cin >> s.division;

	cout << "Enter the address of student : ";
	cin >> s.address;

	ofstream write;
	write.open("student.txt", ios::app);
	write << endl << s.rollNo;
	write << endl << s.name;
	write << endl << s.division;
	write << endl << s.address;
	write.close();

}

void display(Student s) {
	cout << endl << "-------------------------";
	cout << endl << "Roll No. : " << s.rollNo;
	cout << endl << "Name     : " << s.name;
	cout << endl << "Division : " << s.division;
	cout << endl << "Address  : " << s.address;
	cout << endl << "-------------------------";
}

void read() {
	Student s;
	ifstream read;
	read.open("student.txt");

	while (!read.eof()) {
		read >> s.rollNo;
		read >> s.name;
		read >> s.division;
		read >> s.address;

		display(s);
	}

	read.close();
}

int search(int rollNo) {
	Student s;
	ifstream read;
	read.open("student.txt");

	while (!read.eof()) {
		read >> s.rollNo;
		read >> s.name;
		read >> s.division;
		read >> s.address;

		if (rollNo == s.rollNo) {
			cout << endl << "Found!! \n";
			return s.rollNo;
		}
	}
	read.close();
	cout << endl << "Not Found!! \n";
	return -1;
}

void deleteRecord(int rollNo) {

	int result = search(rollNo);
	if (result == -1) {
		cout << endl << "Record not present";
		return;
	} else {
		ofstream write;
		ifstream read;
		Student s;

		write.open("temp.txt", ios::app);
		read.open("student.txt");

		while (!read.eof()) {
			read >> s.rollNo;
			read >> s.name;
			read >> s.division;
			read >> s.address;

			if (s.rollNo != rollNo) {
				write << endl << s.rollNo;
				write << endl << s.name;
				write << endl << s.division;
				write << endl << s.address;
			}
		}
		write.close();
		read.close();

		remove("student.txt");
		rename("temp.txt", "student.txt");
	}
}

int main() {

	int choice;
	do {
		cout << endl << "Press 1 for adding a record";
		cout << endl << "Press 2 for displaying a record";
		cout << endl << "Press 3 for searching a record";
		cout << endl << "Press 4 for deleting a record";
		cout << endl << "Press 0 for exit";

		cout << endl << endl << "Enter your choice : ";
		cin >> choice;

		switch (choice) {
		case 1:
			add();
			break;
		case 2:
			read();
			break;
		case 3:
			int searchValue;
			cout << endl << "Enter roll no. to search : ";
			cin >> searchValue;
			search(searchValue);
			break;
		case 4:
			int rollNo;
			cout << endl << "Enter roll no. of record to be deleted : ";
			cin >> rollNo;
			deleteRecord(rollNo);
			break;
		case 0:
			break;
		default:
			cout << endl << "Wrong Choice!!";
		}
	} while (choice != 0);

	return 0;
}
