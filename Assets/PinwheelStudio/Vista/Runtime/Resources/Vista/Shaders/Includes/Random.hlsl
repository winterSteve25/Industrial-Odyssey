#ifndef RANDOM_INCLUDED
#define RANDOM_INCLUDED

//Source:
//https://math.stackexchange.com/questions/337782/pseudo-random-number-generation-on-the-gpu/340028#340028

struct RandomResult
{
	uint4 state;
	float value;
};

uint TausStep(uint z, int S1, int S2, int S3, uint M)
{
	uint b = (((z << S1) ^ z) >>S2);
	return(((z & M) << S3) ^ b);
}

uint LCGStep(uint z, uint A, uint C)
{
	return(A * z + C);
}

RandomResult Random(uint4 state)
{
	state.x = TausStep(state.x, 13, 19, 12, 4294967294);
	state.y = TausStep(state.y, 2, 25, 4, 4294967288);
	state.z = TausStep(state.z, 3, 11, 17, 4294967280);
	state.w = LCGStep(state.w, 1664525, 1013904223);

	RandomResult result;
	result.state = state;
	result.value = 2.3283064365387e-10 * (state.x ^ state.y ^ state.z ^ state.w);

	return result;
}

#endif //RANDOM_INCLUDED