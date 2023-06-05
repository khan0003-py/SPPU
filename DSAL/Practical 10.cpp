#include<iostream>
using namespace std;

class Heap {
public:
	int minHeap[20];
	int maxHeap[20];
	int n;

	Heap() {
		minHeap[0] = 0;
		maxHeap[0] = 0;
	}

	void getData() {
		int value;
		cout << "Enter no. of students : ";
		cin >> n;
		cout << endl << "Enter marks of students : " << endl;
		for (int i = 1; i <= n; i++) {
			cin >> value;
			insertMin(minHeap, value);
			insertMax(maxHeap, value);
		}
	}

	void insertMax(int heap[], int x) {
		int n;
		n = maxHeap[0];
		maxHeap[n + 1] = x;
		maxHeap[0] = n + 1;

		updateMaxHeap(maxHeap, n + 1);
	}

	void updateMaxHeap(int heap[], int x) {
		int temp;
		while (x > 1 && maxHeap[x] > maxHeap[x / 2]) {
			temp = maxHeap[x];
			maxHeap[x] = maxHeap[x / 2];
			maxHeap[x / 2] = temp;
			x = x / 2;
		}
	}

	void insertMin(int heap[], int x) {
		int n;
		n = minHeap[0];
		minHeap[n + 1] = x;
		minHeap[0] = n + 1;

		updateMinHeap(minHeap, n + 1);

	}

	void updateMinHeap(int heap[], int x) {
		int temp;
		while (x > 1 && minHeap[x] < minHeap[x / 2]) {
			temp = minHeap[x];
			minHeap[x] = minHeap[x / 2];
			minHeap[x / 2] = temp;
			x = x / 2;
		}
	}

	int minMaxValue() {
		cout << endl;
		cout << endl << "Minimum Value : " << minHeap[1];
		cout << endl << "Maximum Value : " << maxHeap[1];
	}
};

int main() {
	Heap h;
	h.getData();
	h.minMaxValue();
	cout << endl;
	cout << "Max Heap Values : ";
	for (int i = 1; i <= h.n; i++) {
		cout << h.maxHeap[i];
		cout<<" - ";
	}
	return 0;
}
