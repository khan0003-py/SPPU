#include<bits/stdc++.h>
using namespace std;

class Node {
public:
	int data;
	Node *right;
	Node *left;

	Node(int data) {
		this->data = data;
		right = NULL;
		left = NULL;
	}
};

class BST {
public:
	Node *root = NULL;
	void insert(int data) {
		Node *temp = new Node(data);
		if (this->root == NULL) {
			this->root = temp;
		} else {
			Node *cur = this->root;
			while (1) {
				if (data >= cur->data) {
					if (cur->right == NULL) {
						cur->right = temp;
						break;
					}
					cur = cur->right;
				} else {
					if (cur->left == NULL) {
						cur->left = temp;
						break;
					}
					cur = cur->left;
				}
			}
		}
	}

	void traverse(Node *node) {
		if (node == NULL) {
			return;
		}

		traverse(node->left);
		cout << node->data << " ";
		traverse(node->right);

	}

	bool search(Node *node, int val) {
		if (node == NULL) {
			return false;
		}
		bool check = false;

		if (val >= node->data) {
			check |= search(node->right, val);
			if (node->data == val) {
				return true;
			}
		} else {
			check |= search(node->left, val);
			if (node->data == val) {
				return true;
			}
		}

		return check;
	}

	int minimum(Node *node) {

		Node *temp;
		temp = node;

		if (temp->left == NULL) {
			return temp->data;
		}
		minimum(temp->left);
	}


	int height(Node *node) {
	    if (node == NULL) {
	        return 0;
	    }
	    int heightRight = 1 + height(node->right);
	    int heightLeft = 1 + height(node->left);

	    return max(heightLeft, heightRight);
	}


	void swap(Node *node) {
		if (node == NULL) {
			return;
		}
		else{
		swap(node->left);
		swap(node->right);

		Node *temp = node->right;
		node->right = node->left;
		node->left = temp;
		}
	}
};

int main() {

	BST t;

	t.insert(10);
	t.insert(-1);
	t.insert(15);
	t.insert(3);
	t.insert(10);
	t.insert(1);
	t.insert(15);
	t.insert(3);

	cout << "Tree Data : ";
	t.traverse(t.root);

	cout << endl << "Search Result : " << t.search(t.root, 19);

	cout << endl << "Minimum Node : " << t.minimum(t.root);

	cout << endl << "Height Of Tree : " << t.height(t.root);

	cout << endl << "Tree Data After Swapping : ";
	t.swap(t.root);
	t.traverse(t.root);

	return 0;
}
