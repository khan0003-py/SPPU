// Author : Arshad Khan
// Instagram : khan0003.py

#include<bits/stdc++.h>
using namespace std;

struct node {
	char name[20];
	node *next;
	node *down;
	int flag;
};

class GLL {
	char ch[20];
	int n, j;
	node *head = NULL, *temp = NULL, *t1 = NULL, *t2 = NULL;
public:
	node* create();
	void insertb();
	void insertc();
	void inserts();
	void insertss();
	void displayb();
};

node* GLL::create() {
	node *p = new node();
	p->next = NULL;
	p->down = NULL;
	p->flag = 0;
	cout << endl << "Enter the name : ";
	cin >> p->name;
	return p;
}

void GLL::insertb() {
	if (head == NULL) {
		t1 = create();
		head = t1;
	} else {
		cout << endl << "Book Exist!!";
	}
}

void GLL::insertc() {
	if (head == NULL) {
		cout << endl << "There is no book is exist.";
	} else {
		cout << endl << "How many chapters you want to insert : ";
		cin >> n;
		for (int i = 0; i < n; i++) {
			t1 = create();
			if (head->flag == 0) {
				head->down = t1;
				head->flag = 1;
			} else {
				temp = head;
				temp = temp->down;
				while (temp->next != NULL) {
					temp = temp->next;
				}
				temp->next = t1;
			}
		}
	}
}

void GLL::inserts() {
	if (head == NULL) {
		cout << endl << "There is no book available";
	} else {
		cout << endl
				<< "Enter the name of chapter on which you want to insert the section : ";
		cin >> ch;
		temp = head;
		if (temp->flag == 0) {
			cout << endl << "No chapter on book is available";
		} else {
			temp = temp->down;
			while (temp != NULL) {
				if (!strcmp(ch, temp->name)) {
					cout << endl << "How many sections you want to insert : ";
					cin >> n;
					for (int i = 0; i < n; i++) {
						t1 = create();
						if (temp->flag == 0) {
							temp->down = t1;
							temp->flag = 1;
							t2 = temp->down;
						} else {
							while (t2->next != NULL) {
								t2 = t2->next;
							}
							t2->next = t1;
						}
					}
					break;
				}
				temp = temp->next;
			}
		}
	}
}

void GLL::insertss() {
	if (temp->next == NULL) {
		cout << endl << "There is no books exist";
	} else {
		temp = head;
		cout << endl
				<< "Enter name of chapter on which you want to insert sub section";
		cin >> ch;
		if (temp->flag == 0) {
			cout << endl << "There is no chapter in the book";
		} else {
			temp = temp->down;
			while (temp != NULL) {
				if (!strcmp(ch, temp->name)) {
					cout << endl
							<< "Enter the name of section on which you want to insert sub section";
					cin >> ch;
					if (temp->flag == 0) {
						cout << endl << "There is no section";
					} else {
						temp = temp->down;
						while (temp != NULL) {
							if (!strcmp(ch, temp->name)) {
								cout
										<< "Enter how many sub section you want to enter : ";
								cin >> n;
								for (int i = 0; i < n; i++) {
									t1 = create();
									if (temp->flag == 0) {
										temp->down = t1;
										temp->flag = 1;
										t2 = temp->down;
									} else {
										while (t2->next != NULL) {
											t2 = t2->next;
										}
										t2->next = t1;
									}
								}
								break;

							}
							temp = temp->next;
						}
					}
				}
				temp = temp->next;
			}
		}
	}
}

void GLL::displayb() {
	if (head == NULL) {
		cout << endl << "There is no book present";
	} else {
		temp = head;
		cout << endl << "Name of book : " << temp->name;
		if (temp->flag == 1) {
			temp = temp->down;
			while (temp != NULL) {
				cout << endl << "\t Name of chapter : " << temp->name;
				t1 = temp;
				if (t1->flag == 1) {
					t1 = t1->down;
					while (t1 != NULL) {
						cout << endl << "\t\t Name of section : " << t1->name;
						t2 = t1;
						if (t2->flag == 1) {
							t2 = t2->down;
							while (t2 != NULL) {
								cout << endl << "\t\t\t Name of sub section : "
										<< t2->name;
								t2 = t2->next;
							}
						}
						t1 = t1->next;
					}
				}
				temp = temp->next;
			}
		}
	}
	cout << endl;
}

int main() {
	GLL g;
	int x;
	while (1) {
		cout << endl << endl << "1. Insert Book.";
		cout << endl << "2. Insert Chapter.";
		cout << endl << "3. Insert Section.";
		cout << endl << "4. Insert Sub-Section.";
		cout << endl << "5. Display Book.";
		cout << endl << "6. Exit" << endl << endl;
		cin >> x;

		switch (x) {
		case 1:
			g.insertb();
			break;
		case 2:
			g.insertc();
			break;
		case 3:
			g.inserts();
			break;
		case 4:
			g.insertss();
			break;
		case 5:
			g.displayb();
			break;
		case 6:
			exit(0);
		}
	}
	return 0;
}


// ©arshad_khan