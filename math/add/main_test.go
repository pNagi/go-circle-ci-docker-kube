package add

import "testing"

func TestAdd(t *testing.T) {
	const firstArg, secondArg, out = 4, 4, 8
	if x := Add(firstArg, secondArg); x != out {
		t.Errorf("Add(%v, %v) = %v, want %v", firstArg, secondArg, x, out)
	}
}
