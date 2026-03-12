import { useDispatch } from 'react-redux';
import type { AppDispatch } from '../store/store';

// Pre-typed version of useDispatch for use throughout the app
const useAppDispatch = () => useDispatch<AppDispatch>();

export default useAppDispatch;
