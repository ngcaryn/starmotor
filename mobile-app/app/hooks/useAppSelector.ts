import { TypedUseSelectorHook, useSelector } from 'react-redux';
import type { RootState } from '../store/store';

// Pre-typed version of useSelector for use throughout the app
const useAppSelector: TypedUseSelectorHook<RootState> = useSelector;

export default useAppSelector;
